from flask import Flask, render_template, request, jsonify
import io
import base64
from rembg import remove
from PIL import Image

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        file = request.files['image']
        input_image = Image.open(file.stream)
        output_image = remove(input_image)
        output_io = io.BytesIO()
        output_image.save(output_io, 'PNG')
        output_io.seek(0)
        output_data = base64.b64encode(output_io.read()).decode('utf-8')
        return jsonify({'output_image': output_data})
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
    app.run(debug=True) 