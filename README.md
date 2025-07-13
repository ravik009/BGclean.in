---
title: BGclean - AI Background Remover
emoji: 🖼️
colorFrom: indigo
colorTo: purple
sdk: flask
sdk_version: 2.3.3
app_file: app.py
pinned: false
---

# BGclean - AI Background Remover

A web application that removes backgrounds from images using AI. Built with Flask and the rembg library.

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

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the application:
```bash
python app.py
```

3. Open http://localhost:7860 in your browser

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