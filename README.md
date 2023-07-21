<h1 align="center">Image Processing Project</h1>

<p align="center">
  <b>Analyze and Process Images using MATLAB</b>
  <br>
  <i>Explore various image processing techniques and operations</i>
</p>

<p align="center">
  <a href="#description">Description</a> •
  <a href="#usage">Usage</a> •
  <a href="#cases">Cases</a> •
  <a href="#examples">Examples</a> •
  <a href="#license">License</a>
</p>

---

## Description

This repository contains an image processing project developed by me. The project includes various image processing techniques and functionalities, implemented in MATLAB. The user can interactively choose different operations to be performed on the input image.

## Usage

To use the project, follow these steps:

1. Clone the repository to your local machine.
2. Open MATLAB and navigate to the project directory.
3. Load an image of your choice into the MATLAB workspace.
4. Run the main script `ImageProcessingMenu.m`.
5. Select an operation from the menu by entering the corresponding number.
6. Follow the instructions for each case to visualize the results.

## Cases

1. **Case1Rotate:** Rotate the image by an angle chosen by the user and display both the original and rotated image.

2. **Case2Complement:** Create the negative of the inserted image and display both the original and negative image.

3. **Case3Conversion:** Convert the image between grayscale and RGB modes.

4. **Case4Mirror:** Mirror the image.

5. **Case6ContrastUp:** Enhance the contrast in the original image.

6. **Case7ContrastDown:** Reduce the contrast in the image by applying a logarithm to the original values.

7. **Case9Zonal:** Observe how a zonal mask works using Discrete Cosine Transform (DCT). The user can select between two types of masks and visualize the results.

8. **Case10Threshold:** Apply a threshold masking to the inserted image. The user can choose different threshold techniques and block dimensions.

9. **Case11Band:** Extract image details using Haar wavelets. The user can choose to visualize all details together or individual channel details for colored images.

10. **Case12Noise:** Add and remove noise from the image. The user can choose Gaussian noise (using wavelet) or Salt-and-Pepper noise (using median filter).

11. **Case13Watermark:** Use `bitget` to add a watermark to the image.

## Examples

Here are some examples of the image processing operations available in this project:

![Example 1](https://github.com/AndreaAlberti07/Image-Processing/blob/main/Examples/DCT_compression.png)
![Example 2](https://github.com/AndreaAlberti07/Image-Processing/blob/main/Examples/Denoise_salt_pepper.png)
![Example 3](https://github.com/AndreaAlberti07/Image-Processing/blob/main/Examples/Wavelet_details.png)

## License

This project is licensed under the [MIT License](LICENSE).

Feel free to explore the code, experiment with different images, and apply these image processing techniques to your own projects.

Enjoy image processing with MATLAB! 🖼️

