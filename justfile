generate_resume_pdf:
    typst compile resume/resume.typ static/resume.pdf

generate_resume_html:
    pandoc resume/resume.typ -o static/resume.html

transfer_svg_to_static:
	cp resume/*.svg static/
