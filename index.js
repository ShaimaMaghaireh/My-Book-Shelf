//? Import required libraries
//const cors =require('cors');
const express = require('express'); // Web framework for Node.js
const mongoose = require('mongoose'); // MongoDB ODM
const bodyParser = require('body-parser'); // Parses incoming request bodies
const app = express();
const PORT = 3003;
//const multer = require('multer');//? for uploading files

//? Middleware to parse JSON bodies
app.use(bodyParser.json());
// Increase payload limit to 10MB (or more if needed)
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));
app.use((req, res, next) => {
    console.log(`Incoming request size: ${req.headers['content-length']} bytes`);
    next();
  });
//app.use(cors);
//? MongoDB Atlas connection
mongoose.connect('mongodb+srv://ShaimaM:sam2512@cluster0.yfwht.mongodb.net/Library', 
{ useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB Atlas'))
    .catch(err => console.log('Error connecting to MongoDB:', err));

//? Define schemas

//? Book schema for storing book details
const bookSchema = new mongoose.Schema({
    title: String,
    author: String,
    availableCopies: Number,
    totalCopies: Number,
    image:String,
    pdf: String,
});

//? User schema for storing user details
const userSchema = new mongoose.Schema({
    name: String,
    email: String,
    password:String,
});

//? Popular Book schema for storing book details
const popularSchema = new mongoose.Schema({
    title1: String,
    author: String,
    image1: String,
    rating: Number,
    isFavorite: Boolean,
    description: String,
});

//? Define models
const Book = mongoose.model('books', bookSchema);
const User = mongoose.model('users', userSchema);
const Popular = mongoose.model('popular', popularSchema);
//? API Endpoints


const bcrypt = require('bcrypt'); //? For password hashing
const password = '123456';
bcrypt.hash('123456', 10, (err, hash) => {
    if (err) throw err;
    console.log('Hashed Password:', hash);
});

//todo Sign Up API
app.post('/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;

        //? Validate inputs
        if (!name || !email || !password) {
            return res.status(400).json({ error: 'All fields are required' });
        }

        // Check if the email is already registered
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(409).json({ error: 'Email already exists' });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create a new user
        const newUser = new User({
            name,
            email,
            password: hashedPassword,
        });

        // Save the user in the database
        await newUser.save();

        // Respond with success
        res.status(201).json({ message: 'User registered successfully', userId: newUser._id });
    } catch (err) {
        console.error('Error during sign-up:', err);
        res.status(500).json({ error: 'Server error' });
    }
});

//todo Login API
app.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Log the incoming request
        console.log('Login request received:', req.body);

        if (!email || !password) {
            console.log('Missing email or password');
            return res.status(400).json({ error: 'Email and password are required' });
        }

        // Find the user by email
        const user = await User.findOne({ email });
        if (!user) {
            console.log('User not found:', email);
            return res.status(404).json({ error: 'User not found' });
        }

        // Compare the provided password with the hashed password in the database
        const isMatch = await bcrypt.compare(password, user.password);
        console.log('Password match status:', isMatch);

        if (!isMatch) {
            return res.status(401).json({ error: 'Invalid email or password' });
        }

        // Respond with success if the login is successful
        console.log('Login successful for user:', user.email);
        return res.status(200).json({
            message: 'Login successful',
            userId: user._id,
            name: user.name,
        });

    } catch (err) {
        // Log the error
        console.error('Error during login:', err);
        res.status(500).json({ error: 'Server error' });
    }
});


//?download the books
app.get('/books/:id/download', async (req, res) => {
    try {
        const bookid =req.params.id;
        const book = await Book.findById(bookid);
       // const book = await Book.findById(req.params.id);
       
        if (!book || !book.pdf) {
            return res.status(404).json({ error: 'Book or file not found' });
        }
        console.log('pdf',book.pdf)

        // Send the file to the client
        res.download(`${book.pdf}`, `${book.title}.pdf`, (err) => {
            if (err) {
                console.error('Error downloading file:', err);
                res.status(500).json({ error: 'Error downloading file' });
            }
        });
    } catch (err) {
        console.error('Error fetching book:', err);
        res.status(500).json({ error: 'Server error' });
    }
});


// app.get('/popular/:id/download', async (req, res) => {
//   try {
//     const bookid = req.params.id;

//     // Validate the book ID
//     if (!mongoose.Types.ObjectId.isValid(bookid)) {
//       return res.status(400).json({ error: 'Invalid book ID format' });
//     }

//     // Find the book in the database
//     const popularbook = await Popular.findById(bookid);

//     if (!popularbook || !popularbook.pdf) {
//       return res.status(404).json({ error: 'Book or file not found' });
//     }

//     const filePath = path.resolve(popularbook.pdf); // Resolve the file path to ensure it's absolute

//     // Check if the file exists on the server
//     if (!fs.existsSync(filePath)) {
//       return res.status(404).json({ error: 'File not found on server' });
//     }

//     // Send the file to the client
//     res.download(filePath, `${popularbook.title1}.pdf`, (err) => {
//       if (err) {
//         console.error('Error downloading file:', err);
//         return res.status(500).json({ error: 'Error downloading file' });
//       }
//     });
//   } catch (err) {
//     console.error('Error fetching book:', err);
//     res.status(500).json({ error: 'Server error' });
//   }
// });

app.get('/popular/:id/download', async (req, res) => {
    try {
        const bookid =req.params.id;
        const popularbook = await Popular.findById(bookid);
       
       
        if (!popularbook || !popularbook.pdf) {
            return res.status(404).json({ error: 'Book or file not found' });
        }
        console.log('pdf',popularbook.pdf)

        // Send the file to the client
        res.download(`${popularbook.pdf}`, `${popularbook.title1}.pdf`, (err) => {
            if (err) {
                console.error('Error downloading file:', err);
                res.status(500).json({ error: 'Error downloading file' });
            }
        });
    } catch (err) {
        console.log(`hellllllllllllllllllllllo????????????????????`)
        console.error('Error fetching book:', err);
        res.status(500).json({ error: 'Server error' });
    }
});

//? Get all books
app.get('/books', async (req, res) => {
    try {
        const books = await Book.find();
        console.log("Retrieved books:", books);
        res.status(200).json(books);
    } catch (err) {
        res.status(500).json({ error: 'Error fetching books' });
    }
   
});

app.get('/users', async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ error: 'Error fetching users' });
    }
});

app.put('/users/:userId', async (req, res) => {
    try {
      const { userId } = req.params;
      const { profileImage } = req.body;
  
      if (!profileImage) {
        return res.status(400).send({ error: 'Profile image is required' });
      }
  
      // Example: Update MongoDB user profile
      const user = await User.findByIdAndUpdate(userId, { profileImage }, { new: true });
  
      if (!user) {
        return res.status(404).send({ error: 'User not found' });
      }
  
      res.status(200).send(user);
    } catch (error) {
      console.error(error);
      res.status(500).send({ error: 'Server error' });
    }
  });
//? Fetch all popular books
app.get("/popular", async (req, res) => {
    try {
        const popularBooks = await Popular.find();
        res.json(popularBooks);
    } catch (err) {
        res.status(500).send("Error fetching popular books: " + err.message);
    }
});

//? Update favorite status for popular books
app.put("/popular/:id", async (req, res) => {
    const { id } = req.params;
    const { isFavorite } = req.body;
    const book = await Book.findByIdAndUpdate(id, { isFavorite }, { new: true });
    res.json(book);
});


//todo Search books by title
app.get('/search-books', async (req, res) => {
    try {
        const { title } = req.query; // Get the title from query parameters

        if (!title) {
            return res.status(400).json({ error: 'Title is required' });
        }

        // Use regex for partial and case-insensitive matching
        const books = await Book.find({ title: new RegExp(title, 'i') });

        res.status(200).json(books);
    } catch (err) {
        console.error('Error during book search:', err);
        res.status(500).json({ error: 'Server error' });
    }
});





//? Borrow a book
app.post('/borrow', async (req, res) => {
    const { userId, bookId } = req.body;
    try {
        const user = await User.findById(userId);
        const book = await Book.findById(bookId);

        if (book.availableCopies > 0) {
            book.availableCopies -= 1;
            user.borrowedBooks.push({ bookId });
            await book.save();
            await user.save();
            res.status(200).json({ message: 'Book borrowed successfully' });
        } else {
            res.status(400).json({ error: 'No copies available' });
        }
    } catch (err) {
        res.status(500).json({ error: 'Error borrowing book' });
    }
});

//? Add book to the read list
app.post('/read-list', async (req, res) => {
    const { userId, bookId } = req.body;
    try {
        const user = await User.findById(userId);
        if (!user.readList.includes(bookId)) {
            user.readList.push(bookId);
            await user.save();
            res.status(200).json({ message: 'Book added to the read list' });
        } else {
            res.status(400).json({ error: 'Book already in read list' });
        }
    } catch (err) {
        res.status(500).json({ error: 'Error adding book to read list' });
    }
});

//? Start the server
// app.listen(PORT, () => {
//     console.log(`Server running on http://localhost:${PORT}`);
// });


app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on http://${getIPAddress()}:${PORT}`);
  });
  
  function getIPAddress() {
    const { networkInterfaces } = require('os');
    const nets = networkInterfaces();
    for (const name of Object.keys(nets)) {
        for (const net of nets[name]) {
            // Skip over non-IPv4 and internal (i.e., 127.0.0.1) addresses
            if (net.family === 'IPv4' && !net.internal) {
                return net.address;
            }
        }
    }
  }