# salloc --ntasks=1 --cpus-per-task=24 --time=00:20:00 --mem-per-cpu=1200M --nodes=1 --account=rrg-sushama-ab --x11
module load StdEnv/2023  gcc/12.3  openmpi/4.1.5  cuda/12.2
git clone https://github.com/hypre-space/hypre.git
cd hypre
mkdir install
./configure --prefix=/home/***/projects/ctb-sushama/***/REEF3D_compile_2/hypre/install
cd src
make -j 10 all
make install
export PATH="/home/***/projects/ctb-sushama/***/REEF3D_compile_2/hypre/install/include:$PATH"
export PATH="/home/***/projects/ctb-sushama/***/REEF3D_compile_2/hypre/install/lib:$PATH"

### cd to REEF3D
# in Makefile HYPRE_DIR    := /usr/local/hypre  ---->>> HYPRE_DIR    := /home/***/projects/ctb-sushama/***/REEF3D_compile_2/hypre/install
make -j 16
