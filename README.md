Welcome to the official **CMMR Developer News blog!** This site is a centralized hub for the bioinformatics team's announcements, news, and technical tutorials.

This blog is built using **Quarto**, a multi-language, next-generation version of RMarkdown. It allows us to combine prose, code, and high-quality output into a single document.

------------------------------------------------------------------------

## 🛠️ Getting Started

To contribute to the blog, you will first need to clone the repository to your local machine:

``` bash
git clone https://github.com/cmmr/cmmr.github.io.git
```

### How to Create a Post

1.  Navigate to the `posts/` directory.
2.  Create a new folder named with the format `YYYY-MM-DD-short-title`.
3.  Inside that folder, create a file named `index.qmd`.

------------------------------------------------------------------------

## 🧬 Information for R Developers

Most of you will use **RStudio** or **Positron**. These IDEs come with Quarto pre-installed.

### Previewing Your Work

-   **RStudio/Positron:** Click the **Render** button at the top of the editor. This will open a live preview in the "Viewer" pane.
-   **Manual:** Run `quarto preview index.qmd` in the RStudio terminal.

### Managing Dependencies

If you are NOT rendering locally (letting GitHub Actions do it), you must include an **R** setup block at the top of your `index.qmd` so the cloud runner knows what to install:

    ```{r, include=FALSE}
    if (identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {
      pak::pak(c("h5lite", "rbiom", "ggplot2"))
    }
    ```

------------------------------------------------------------------------

## 🐍 Information for Python Developers

You can write your entire post in Python or mix Python and R.

### Getting Quarto

If you use **VS Code** or **PyCharm**, you may need to install the Quarto CLI manually.

-   **Install:** Download the installer from [quarto.org](https://quarto.org/docs/get-started/).
-   **Extension:** Install the "Quarto" extension for VS Code for the best experience.

### Managing Dependencies

The GitHub Action runner includes a base Python installation. The easiest way to install your specific libraries is using a **bash** setup block at the top of your post:

    ```{bash, include=FALSE}
    if [ "$GITHUB_ACTIONS" == "true" ]; then
      pip install pandas matplotlib numpy h5py
    fi
    ```

------------------------------------------------------------------------

## 🚀 Publishing to the Site

### Option 1: The "Cloud Render" (Easiest)

Simply commit your `index.qmd` file. Our GitHub Action will see the new file, install the dependencies you specified in your setup blocks, render the post, and publish it.

### Option 2: The "Local Freeze" (Best for Large Data)

If your code takes a long time to run or requires access to local lab databases, render it on your machine first:

1.  Run `quarto render index.qmd`.
2.  This generates a folder in the project root called `_freeze/`.
3.  **Commit your newly generated `posts/` and `_freeze/` files.**

GitHub will see the "frozen" results and skip running your code, ensuring the post looks exactly as it did on your screen.

### Pushing to GitHub

``` bash
git add .
git commit -m "Add new post: Analysis of microbiome trends"
git push origin master
```

------------------------------------------------------------------------

## 📡 Share Your Work

Our blog is configured to automatically share your expertise with the global data science community via RSS feeds. 


### How it Works
Any post you tag with the category `R` is automatically bundled into a specialized "R-only" feed. Aggregators like **R-bloggers** and **RWeekly** "watch" this feed and will automatically re-post your content to their audiences shortly after you push to GitHub.


### Active Feed Mappings
Use this table to track where our content is being syndicated. If you set up a new connection (e.g., to a Python aggregator or a specific bioinformatics planet), please add it to this list.

| Aggregator | Content Filter | Feed URL |
| :--- | :--- | :--- |
| [**R-bloggers**](https://www.r-bloggers.com/) | R-related only | `https://cmmr.github.io/categories/r/index.xml` |
| [**RWeekly**](https://rweekly.org) | R-related only | `https://cmmr.github.io/categories/r/index.xml` |

### ⚠️ Warning: Category Discipline
Please be mindful of your `categories` list in the YAML header. Mis-categorizing a post (e.g., sending a non-R post to R-bloggers) is considered poor "netiquette" and can result in our lab's feed being throttled or removed from these aggregators.

---


## 📝 The Anatomy of a `.qmd` File

Every post is a single `.qmd` file. It combines a metadata header (YAML) with your text and code. 

### Example `index.qmd`

    ---
    title: "Deep Dive into h5lite"
    author: "Your Name"
    date: "2026-02-13"
    description: "A quick summary of what this post is about."
    image: "thumbnail.png" # The thumbnail shown in gallery grids
    categories: [R, hdf5, tutorial] # 'R' tag triggers RSS syndication
    ---
    
    ## Introduction
    
    This is standard Markdown. You can use **bold**, *italics*, and [links](https://google.com).
    
    ### R Setup Block
    ```{r}
    #| label: setup-r
    #| include: false
    
    # Installation block for GitHub Actions
    if (identical(Sys.getenv("GITHUB_ACTIONS"), "true")) {
      pak::pak(c("h5lite", "ggplot2"))
    }
    ```
    
    ### Python Analysis Block
    ```{python}
    #| label: python-viz
    import matplotlib.pyplot as plt
    plt.plot([1, 2, 3], [4, 5, 6])
    plt.show()
    ```


---

## 📚 Quarto Resources

Quarto uses a specific flavor of Markdown and a unique syntax for managing code output. Refer to these guides when writing your posts:

* **[Quarto Markdown Basics](https://quarto.org/docs/authoring/markdown-basics.html)**: A guide to text formatting, headers, equations, and citations.

* **[Executable Code Blocks](https://quarto.org/docs/computations/execution-options.html)**: Learn how to use "Cell Options" (like `#| echo: false` or `#| label: fig-1`) to control how your code and plots appear.

* **[Figures and Layout](https://quarto.org/docs/authoring/figures.html)**: How to create sub-plots, cross-references, and captions.
