import os
os.environ["NUMBA_CACHE_DIR"] = "/tmp/numba_cache"
from flask import Flask, render_template, request, jsonify
import io
import base64
from rembg import remove
from PIL import Image
import os
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        try:
            file = request.files['image']
            if file and file.filename:
                # Read and process the image
                input_image = Image.open(file.stream)
                
                # Remove background using rembg
                output_image = remove(input_image)
                
                # Convert to base64 for sending back
                output_io = io.BytesIO()
                output_image.save(output_io, 'PNG')
                output_io.seek(0)
                output_data = base64.b64encode(output_io.read()).decode('utf-8')
                
                return jsonify({
                    'success': True,
                    'output_image': output_data
                })
            else:
                return jsonify({
                    'success': False,
                    'error': 'No file uploaded'
                }), 400
        except Exception as e:
            return jsonify({
                'success': False,
                'error': str(e)
            }), 500
    
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/terms')
def terms():
    return render_template('terms.html')

if __name__ == '__main__':
    # For Hugging Face Spaces, use the PORT environment variable
    port = int(os.environ.get('PORT', 7860))
    app.run(host='0.0.0.0', port=port, debug=False)  