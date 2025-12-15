# ECE253 Final Project: A Unified Comparative Framework for Image Restoration

## 1. Dehazing (Direction A)
1.  Navigate to the directory: `Dehazing/notebooks/`.
2.  Open and run the following notebooks to reproduce the results found in the report:
    * **DCP Experiments:** Run `dcp_outdoor.ipynb` (for RESIDE outdoor photos), `dcp_indoor.ipynb` (for RESIDE indoor photos) and `dcp_ohaze.ipynb` (for O-HAZE).
    * **AOD-Net Experiments:** Run `aod.ipynb` (for RESIDE) and `aod_ohaze.ipynb` (for O-HAZE).
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

*(Pending: Instructions will be updated once the code is merged).*

---

## Release Note
This code corresponds to the submission version **v1.0-report-version**.