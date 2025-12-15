# ECE253 Final Project: A Unified Comparative Framework for Image Restoration

This repository contains the source code, datasets, and experimental results for our ECE253 final project. The project compares classical and learning-based methods across three tasks: Dehazing, Deblurring, and Denoising.

## 1. Dehazing (Direction A)

### Directory Structure
* `Dehazing/data/`: Contains the datasets used for evaluation.
  * `RESIDE/`: Synthetic outdoor testing set.
  * `OHAZE/`: Real-world haze dataset.
  * `MYHAZE/`: Self-captured real-world hazy images.
* `Dehazing/notebooks/`: Contains Jupyter Notebooks for running experiments.
* `Dehazing/PyTorch-Image-Dehazing/snapshots/`: Contains the pre-trained AOD-Net model (`dehazer.pth`).

### How to Run
1.  Navigate to the directory: `Dehazing/notebooks/`.
2.  Open and run the following notebooks to reproduce the results found in the report:
    * **DCP Experiments:** Run `dcp_outdoor.ipynb` (for RESIDE outdoor photos), `dcp_indoor.ipynb` (for RESIDE indoor photos) and `dcp_ohaze.ipynb` (for O-HAZE).
    * **AOD-Net Experiments:** Run `aod.ipynb` (for RESIDE) and `aod_ohaze.ipynb` (for O-HAZE).
    * **Our Own Photos:** Run `myhaze.ipynb`.
3.  The notebooks will generate visual comparisons and print quantitative metrics (PSNR, SSIM, NIQE, etc.).

---

## 2. Deblurring (Direction B)

### How to Run
1.  Open MATLAB.
2.  Navigate to the `Deblurring/` directory.
3.  Run the script `run.m`.
4.  This script will execute the blind deblurring algorithms and display the test results.

---

## 3. Denoising (Direction C)

### Directory Structure
* `Denoising/data/`: Contains the test datasets (BSD68 and Real-World Noise).
* `Denoising/models/`: Directory for storing the pre-trained model.
* `Denoising/notebooks/`: Contains the implementation notebooks for Wavelet, SVR, and DnCNN.

### Prerequisites
* Python 3.x
* Key libraries: `torch`, `numpy`, `opencv-python`, `scikit-image`, `scikit-learn`, `PyWavelets`.
* Alternatively, install the environment via conda: `conda env create -f Denoising/environment.yml`

### How to Run
1.  **Model Setup:** Download the pre-trained DnCNN model (`dncnn_50.pth`) from [Google Drive](https://drive.google.com/file/d/1tQ_j9Lz_QzX8_QzX8_QzX8/view?usp=sharing) and place it in the `Denoising/models/` directory.
2.  Navigate to the directory: `Denoising/notebooks/`.
3.  Run the following notebooks to reproduce the results:
    * **Classical Methods:** Run `1_Wavelet_Denoising.ipynb` and `2_SVR_Denoising.ipynb`.
    * **Deep Learning (DnCNN):** Run `3_DnCNN_Denoising.ipynb`.
    * **Real-World Test:** Run `4_Real_World_Denoising.ipynb`.

---

## Release Note
This code corresponds to the submission version **v1.0-report-version**.