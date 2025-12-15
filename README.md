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
2.  **Pre-trained Model:** The AOD-Net experiments rely on the pre-trained weight file located at `../PyTorch-Image-Dehazing/snapshots/dehazer.pth`. Please ensure this file is present (included in the repo).
3.  Open and run the following notebooks to reproduce the results found in the report:
    * **DCP Experiments:** Run `dcp_outdoor.ipynb` (for RESIDE outdoor photos), `dcp_indoor.ipynb` (for RESIDE indoor photos), and `dcp_ohaze.ipynb` (for O-HAZE).
    * **AOD-Net Experiments:** Run `aod.ipynb` (for RESIDE) and `aod_ohaze.ipynb` (for O-HAZE).
    * **Our Own Photos:** Run `myhaze.ipynb`.
4.  The notebooks will generate visual comparisons and print quantitative metrics (PSNR, SSIM, NIQE, etc.).

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
* `Denoising/data/`: Contains the image datasets.
    * `clean/`: Clean reference images.
    * `noisy/`: Pre-generated noisy images.
    * `real/`: Real noisy images (e.g., SIDD or captured photos).
* `Denoising/Results/`: Stores generated logs and comparative images.

### How to Run
1.  Navigate to the `Denoising/` directory.
2.  **Dependencies:** Ensure you have Python 3.9+ and the required libraries installed (`numpy`, `opencv-python`, `torch`, `matplotlib`, `scikit-learn`, `scikit-image`).
3.  Open and run the following notebooks:
4.  Run the following notebooks to reproduce the results:
     * **Classical Methods:** Run ```denoiseing. ipynb`.
    * **SVR:** Run`denoiseing_SVR.ipynb.
    * **Deep Learning (DnCNN):** Run `dncnn.ipynb`.

5.  **Real-World Test:**
    * **Classical Methods:** Run ```wavelet_bicycle. ipynb`.
    * **SVR:** Run`bicycle_svr.ipynb.
    * **Deep Learning (DnCNN):** Run `dncnn_bicycle.ipynb`.
6.* **Generate Figures:** Run `figurePSNR.ipynb` to create the summary plots used in the report.

---

## Release Note
This code corresponds to the submission version **v1.0-report-version**.
