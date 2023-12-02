FROM ubuntu:22.04

RUN apt update && apt install -y build-essential git flex bison gcc-multilib g++-multilib
RUN git clone https://gitlab.com/HenryKautz/BlackBox.git
RUN cd BlackBox; make