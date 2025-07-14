import React, { useState } from "react";

export default function BgRemoveUpload() {
  const [selectedFile, setSelectedFile] = useState(null);
  const [outputImage, setOutputImage] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleFileChange = (e) => {
    setSelectedFile(e.target.files[0]);
    setOutputImage(null);
    setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!selectedFile) {
      setError("Please select an image file.");
      return;
    }
    setLoading(true);
    setError("");
    setOutputImage(null);

    const formData = new FormData();
    formData.append("image", selectedFile);

    try {
      const res = await fetch("https://ravikumar619--BGclean1.hf.space/", {
        method: "POST",
        body: formData,
      });
      const data = await res.json();
      if (data.success) {
        setOutputImage(data.output_image);
      } else {
        setError(data.error || "Background removal failed.");
      }
    } catch (err) {
      setError("Network error or server not reachable.");
    }
    setLoading(false);
  };

  return (
    <div style={{ maxWidth: 400, margin: "auto", textAlign: "center" }}>
      <form onSubmit={handleSubmit}>
        <input
          type="file"
          accept="image/*"
          onChange={handleFileChange}
        />
        <button type="submit" disabled={loading}>
          {loading ? "Processing..." : "Remove Background"}
        </button>
      </form>
      {error && <div style={{ color: "red", marginTop: 10 }}>{error}</div>}
      {outputImage && (
        <div style={{ marginTop: 20 }}>
          <img
            src={`data:image/png;base64,${outputImage}`}
            alt="Output"
            style={{ maxWidth: "100%", border: "1px solid #ddd" }}
          />
          <a
            href={`data:image/png;base64,${outputImage}`}
            download="output.png"
            style={{
              display: "block",
              marginTop: 10,
              color: "#fff",
              background: "#6366f1",
              padding: "8px 16px",
              borderRadius: 6,
              textDecoration: "none",
              fontWeight: 600,
            }}
          >
            Download PNG
          </a>
        </div>
      )}
    </div>
  );
} 