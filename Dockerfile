FROM archlinux:latest
MAINTAINER JD

RUN pacman -Suyy --needed --noconfirm
RUN pacman -Syy --noconfirm wget gcc make openssh subversion git perl gcc-fortran openmpi netcdf-fortran-openmpi

RUN wget https://forge.nemo-ocean.eu/nemo/nemo/-/archive/${NEMOGCM_VER}/nemo-${NEMOGCM_VER}.tar.bz2
