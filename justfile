generate_resume_pdf:
    mkdir -p out
    typst compile resume/resume.typ static/resume.pdf

generate_resume_html:
    mkdir -p out
    pandoc resume/resume.typ -o static/resume.html

