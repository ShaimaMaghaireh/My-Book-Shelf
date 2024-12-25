//? Import required libraries
const express = require('express'); // Web framework for Node.js
const mongoose = require('mongoose'); // MongoDB ODM
const bodyParser = require('body-parser'); // Parses incoming request bodies
const app = express();
const PORT = 3001;

//? Middleware to parse JSON bodies
app.use(bodyParser.json());

//? MongoDB Atlas connection
mongoose.connect('mongodb+srv://ShaimaM:sam2512@cluster0.yfwht.mongodb.net/Library', { useNewUrlParser: true, useUnifiedTopology: true })
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
});

//? User schema for storing user details
const userSchema = new mongoose.Schema({
    name: String,
    email: String,
    borrowedBooks: [
        {
            bookId: mongoose.Schema.Types.ObjectId,
            borrowedOn: { type: Date, default: Date.now }
        }
    ],
    readList: [mongoose.Schema.Types.ObjectId]
});

//? Define models
const Book = mongoose.model('books', bookSchema);
const User = mongoose.model('users', userSchema);

//? API Endpoints

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
        res.status(500).json({ error: 'Error fetching books' });
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
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
