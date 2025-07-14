// Hugging Face API integration
async function callHuggingFaceAPI(selectedFile) {
    const removeBtn = document.querySelector('.remove-btn');
    const status = document.getElementById('status');
    const outputImg = document.getElementById('output-img');
  
    try {
      if (removeBtn) {
        removeBtn.textContent = 'Processing...';
        removeBtn.disabled = true;
      }
  
      status.textContent = 'Uploading and processing...';
  
      const formData = new FormData();
      formData.append("file", selectedFile);
  
      const response = await fetch("https://ravikumar619-bgclean1.hf.space/remove-background", {
        method: "POST",
        body: formData,
      });
  
      if (!response.ok) throw new Error("Failed to process image");
  
      const blob = await response.blob();
      const imageUrl = URL.createObjectURL(blob);
  
      outputImg.src = imageUrl;
      outputImg.style.display = 'block';
  
      const downloadLink = document.getElementById('download-link');
      if (downloadLink) {
        downloadLink.href = imageUrl;
        downloadLink.download = 'bg-removed.png';
        downloadLink.style.display = 'inline-block';
      }
  
      status.textContent = "Done!";
    } catch (err) {
      console.error(err);
      status.textContent = "Error: " + err.message;
    } finally {
      if (removeBtn) {
        removeBtn.textContent = 'Remove Background';
        removeBtn.disabled = false;
      }
    }
  }
  
  // File input handler
  const fileInput = document.getElementById('file-input');
  if (fileInput) {
    fileInput.addEventListener('change', function (e) {
      const selectedFile = e.target.files[0];
      const previewImg = document.getElementById('preview-img');
      if (selectedFile && previewImg) {
        const reader = new FileReader();
        reader.onload = function (e) {
          previewImg.src = e.target.result;
          previewImg.style.display = 'block';
        };
        reader.readAsDataURL(selectedFile);
      }
    });
  }
  
  // Remove button handler
  const removeBtn = document.querySelector('.remove-btn');
  if (removeBtn) {
    removeBtn.addEventListener('click', function () {
      const selectedFile = document.getElementById('file-input').files[0];
      if (!selectedFile) {
        alert("Please select an image first!");
        return;
      }
      callHuggingFaceAPI(selectedFile);
    });
  }
  