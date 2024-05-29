# Notes for using slides

Some quick information about how to use the slides when delivering the course.

The slides are written in Jupytext markdown format.
This means they can be viewed as a Jupyter notebook if you have Jupytext installed (see below).
The slideshow is viewed using the RISE extension of Jupyter.
At the moment, the final HTML is not stored,
so you need to have Jupyter with some extensions installed.
A virtual environment with a subsequent `pip` command is recommended:

```bash
python3 -m venv .venv  # it is important to use the dot prefix if you are creating this at the top level of this repo
. .venv/bin/activate
pip install -r slides/requirements.txt 
# launch jupyter from the top level of this repo, **not** in the slide
# directory or else the relative figure links won't work
jupyter-notebook
# navigate to the slide file, open with notebook and edit.
```

Use the RISE extension to Jupyter to view the slides.
This allows you to enter the slideshow from the Jupyter notebook web interface.
There should be a button with a histogram on the Jupyter notebook toolbar
(you might need to go to the 'View' menu to get the toolbar to show).
Click the button, or press `Alt-r` to launch the RISE presentation view.
Use spacebar to advance slides. Presenter view with `t`.

Saving the slides from the Jupyter interface should only save to the markdown source file.
If you find you have ended up with some `.ipynb` files in the `slides/` directory,
then you have done something wrong. Don't check those `.ipynb` files into version control.

## Slide Export

If you want to have the slides in HTML format for portability or printing, then please used the
following bash command:

```bash
jupytext --from md:markdown --to notebook --output - <markdown_slide_file> | jupyter nbconvert --stdin --to slides --embed-images --output <html_output_filename>
```

To do this for all slides, use the bash script `slides/slides_to_html.bash`.

## Screen Arrangement for Remote Delivery

- Screen 1
  - if there is a size difference in your screens, this should be the largest one
  - shared with participants
  - web browser with jupyter-notebook for current section open, `alt-r` to get presentation view,
  then `t` to get presenter view window which should be put on screen 2
    - tab with course content page
    - tab with GitHub repo of example project
  - PyCharm with example project open
  - Terminal with current directory in example project
- Screen 2
  - smaller, not shared
  - terminal running jupyter-notebook server for slides
  - presenter view (produced from going to presenter view above)
  - Zoom window
  - Web browser
    - workshop website
    - course content
    - collaborative document
    - any other resources you think you might need to refer to
  - messaging app for communication with helpers
