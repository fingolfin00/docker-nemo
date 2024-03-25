FROM archlinux:latest

RUN pacman -Suyy --needed --noconfirm
RUN pacman -Syy --noconfirm wget tar bzip2 gcc make openssh subversion git perl perl-uri gcc-fortran netcdf-fortran-openmpi

ARG XIOS_ARCH="GCC_LINUX"
RUN svn co http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS2/trunk xios
RUN sed -i 's/gmake/make/g' /xios/arch/arch-${XIOS_ARCH}.fcm
RUN sed -i '9i  #include <cstdint>' $(find /xios/ -type f -name "earcut.hpp")
RUN cd xios; ./make_xios --prod --arch ${XIOS_ARCH}

ARG NEMOGCM_VER="4.2.2"
RUN wget https://forge.nemo-ocean.eu/nemo/nemo/-/archive/${NEMOGCM_VER}/nemo-${NEMOGCM_VER}.tar.bz2
RUN tar -xf nemo-${NEMOGCM_VER}.tar.bz2
ADD arch-docker.fcm /nemo-${NEMOGCM_VER}/arch
RUN cd /nemo-${NEMOGCM_VER}; ./makenemo -m 'docker' -a VORTEX -n 'MY_VORTEX' 2>&1 | tee vortex-make.log

