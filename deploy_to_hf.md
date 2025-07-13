# Hugging Face Spaces Deployment Guide

## Step-by-Step Instructions

### 1. Prepare Your Repository

Make sure your repository has these essential files:
- ✅ `app.py` - Main Flask application
- ✅ `requirements.txt` - Python dependencies
- ✅ `templates/` - HTML templates
- ✅ `Static/` - Static assets
- ✅ `README.md` - Project documentation

### 2. Create a GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it something like `bgclean-hf-spaces`
3. Make it public (required for free Hugging Face Spaces)
4. Upload all your project files

### 3. Create Hugging Face Space

1. Go to [Hugging Face Spaces](https://huggingface.co/spaces)
2. Click "Create new Space"
3. Fill in the details:
   - **Owner**: Your Hugging Face username
   - **Space name**: `bgclean` (or any name you prefer)
   - **License**: MIT
   - **SDK**: Select **Flask**
   - **Python version**: 3.10 or higher
4. Click "Create Space"

### 4. Connect Your Repository

1. In your new Space, go to "Settings" tab
2. Under "Repository", click "Connect to GitHub"
3. Select your repository
4. The Space will automatically sync with your GitHub repository

### 5. Configure Build Settings

1. In Space settings, go to "Build and Deploy"
2. Make sure these settings are correct:
   - **Python version**: 3.10 or higher
   - **App file**: `app.py`
   - **Requirements file**: `requirements.txt`

### 6. Deploy

1. The Space will automatically start building when you connect the repository
2. You can monitor the build process in the "Logs" tab
3. Once built successfully, your app will be live at:
   `https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME`

### 7. Custom Domain (Optional)

1. In Space settings, go to "Custom Domain"
2. Add your custom domain if you have one

## Troubleshooting

### Common Issues:

1. **Build fails**: Check the logs for dependency issues
2. **App not loading**: Verify `app.py` is the correct entry point
3. **Port issues**: Make sure your app uses the `PORT` environment variable
4. **Memory issues**: Consider using a smaller model or optimizing the code

### Performance Tips:

1. **Use CPU-only models** for faster deployment
2. **Optimize image processing** for web use
3. **Add caching** for processed images
4. **Use CDN** for static assets

## Monitoring

- Check the "Logs" tab for real-time application logs
- Monitor resource usage in the "Settings" tab
- Set up alerts for any issues

## Updates

To update your deployed application:
1. Push changes to your GitHub repository
2. Hugging Face Spaces will automatically rebuild and deploy
3. Monitor the build process in the "Logs" tab

## Support

If you encounter issues:
1. Check the [Hugging Face Spaces documentation](https://huggingface.co/docs/hub/spaces)
2. Review the build logs for error messages
3. Ask for help in the [Hugging Face community](https://huggingface.co/forums) 