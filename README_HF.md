# BGclean - AI Background Remover on Hugging Face Spaces

This is a Flask web application that removes backgrounds from images using AI, deployed on Hugging Face Spaces.

## 🚀 Live Demo

The application is live at: [Your Hugging Face Space URL]

## Features

- ✨ Instant background removal using AI
- 🖼️ Support for various image formats (JPG, PNG, etc.)
- 🎨 Clean and modern web interface
- 📱 Responsive design
- ⚡ Real-time processing

## How to Use

1. **Upload Image**: Click the upload area or drag and drop your image
2. **Process**: Click "Remove Background" to start the AI processing
3. **Download**: Get your image with transparent background

## Technology Stack

- **Backend**: Flask (Python)
- **AI Model**: rembg (U2Net)
- **Frontend**: HTML, CSS, JavaScript
- **Deployment**: Hugging Face Spaces

## Local Development

1. Clone this repository
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the application:
   ```bash
   python app.py
   ```
4. Open http://localhost:7860 in your browser

## Deployment on Hugging Face Spaces

This repository is configured for automatic deployment on Hugging Face Spaces:

1. **Fork this repository** to your GitHub account
2. **Create a new Space** on Hugging Face:
   - Go to https://huggingface.co/spaces
   - Click "Create new Space"
   - Choose "Flask" as the SDK
   - Connect your forked repository
3. **Configure the Space**:
   - Set the Python version to 3.10 or higher
   - The Space will automatically detect and use the `app.py` file
4. **Deploy**: The Space will automatically build and deploy your application

## Files Structure

```
├── app.py              # Main Flask application
├── requirements.txt    # Python dependencies
├── templates/          # HTML templates
│   ├── index.html     # Main page
│   ├── about.html     # About page
│   ├── contact.html   # Contact page
│   └── terms.html     # Terms page
└── Static/            # Static assets
    ├── favicon.png    # Favicon
    └── upload.png     # Upload icon
```

## API Endpoints

- `GET /` - Main application page
- `POST /` - Upload and process image
- `GET /about` - About page
- `GET /contact` - Contact page
- `GET /terms` - Terms page

## Environment Variables

The application uses the following environment variables:
- `PORT` - Server port (default: 7860)

## License

MIT License

## Contributing

Feel free to submit issues and enhancement requests! 