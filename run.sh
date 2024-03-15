#!/bin/bash -l
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 4G
#SBATCH --time 1:00:00
#SBATCH --partition gpu
#SBATCH --account cs413
#SBATCH --qos cs413

echo "Loading modules"
module load gcc python openmpi py-torch

echo "Loading venv"
virtualenv --system-site-packages ~/venvs/neural-style-pt

echo "Activating venv"
source ~/venvs/neural-style-pt/bin/activate

echo "Installing dependencies"
pip install numpy pillow torch torchvision

echo "Running image synthesis"
python neural_style.py -style-image examples/inputs/cinestill1.jpg -content-image examples/inputs/epfl.jpg -output-image examples/outputs/epfl1.jpg
python neural_style.py -style-image examples/inputs/cinestill2.jpg -content-image examples/inputs/epfl.jpg -output-image examples/outputs/epfl2.jpg
python neural_style.py -style-image examples/inputs/cinestill1.jpg -content-image examples/inputs/trains.jpg -output-image examples/outputs/trains1.jpg
python neural_style.py -style-image examples/inputs/cinestill2.jpg -content-image examples/inputs/trains.jpg -output-image examples/outputs/trains2.jpg

# to stop venv
deactivate
