# Notes for Using Slides

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
# directory or else the relative figure links will not work
jupyter-notebook #  or `jupyter-lab`
# navigate to the slide file, right click then select "open with > notebook".
```

> Note: we have had mixed success using the RISE extension in both `jupyter-notebook` and `jupyter-lab`.
> Try the other if one isn't working for you.
> To use the old `jupyter-notebook`, put this in the `requirements.txt` file:
>
> ```requirements
> notebook < 7.0.0
> rise
> jupytext
> ```

Use the RISE extension of Jupyter to view and edit the slides.
There is now a substantial interface difference between the two modalities (`jupyter-notebook` vs `jupyter-lab`).

## Viewing and Editing Slides in Jupyter Notebook

There should be a "projector screen" button on the Jupyter notebook toolbar next to the kernel name
(you might need to go to the 'View' menu to get the toolbar to show).
Click this button, or press `Alt-r` to launch the RISE presentation view.

## Viewing and Editing Slides in Jupyter Lab

- Click on the folder icon on the left-hand panel to get the file viewer
- Right click on the slide files you want to view or edit
- Select "Open With ▶" then "Rise Slides"
- The rendered version of the slides should come up, and you can edit them from here.
  One downside is that the notes are not also displayed, unless you get the presenter view as described below.
- If you need to edit notes, it might be best to edit the markdown file directly.
  You can do this from the file explorer again selecting "Open With ▶" and then "Jupytext Notebook".
- The type of slide is set by using the "Property Inspector" on the right hand panel (two cogs icon).

## Navigating

Use `Space` to advance slides, `Shift + Space` to go back.
The arrow keys on your keyboard will not work like you expect!
Bring up presenter view with `t`, which will show the notes for a given slide.

## Saving Slides

Saving the slides from the Jupyter interface should only save to the markdown source file.
If you find you have ended up with some `.ipynb` files in the `slides/` directory,
then you have done something wrong. Do not check those `.ipynb` files into version control.

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
  - An IDE (PyCharm or VS Code) with example project open
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
