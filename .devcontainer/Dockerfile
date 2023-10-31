FROM mcr.microsoft.com/devcontainers/base:jammy

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sbcl

# Install ALIVE dependencies
COPY ./lisp_deps /
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp
RUN sudo -u vscode sbcl --script /lisp_deps
RUN rm /lisp_deps /quicklisp.lisp

COPY ./.sbclrc /home/vscode/