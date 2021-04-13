# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

default: html
	true

# Install dependenciences for gh-pages.  This is only intended for CI,
# but is put here instead of in the Actions file to avoid locking us
# in to the github actions formats.
gh-pages-dependencies:
	true
#	apt install texlive-latex-recommended \
#	    texlive-fonts-recommended \
#	    texlive-fonts-extra \
#            texlive-latex-extra \
#	    texlive-xetex \
#            latexmk
# Do all required building for gh-pages, copy the site to
# _build/gh-pages.
gh-pages: dirhtml singlehtml
	mkdir -p _build/gh-pages/
	mkdir -p _build/gh-pages/_builds/
	rsync -a _build/dirhtml/ _build/gh-pages/
	rsync -a _build/singlehtml/ _build/gh-pages/_builds/singlehtml/

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
