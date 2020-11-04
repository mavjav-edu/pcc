---
layout: default
title: Chapter 10
---

Updates
---

Some of the text files from [Project Gutenberg](https://www.gutenberg.org/) are now encoded as utf-8. This can result in a `UnicodeDecodeError` when trying to open the file. This can be addressed by adding an argument when we call `open()`, which explictly tells Python which encoding to use when opening the file.  For example, in the program *alice.py* on pages 203-204, the first lines of the program should look like this:

    filename = 'alice_new.txt'

    try:
        with open(filename, encoding='utf-8') as f_obj:
            contents = f_obj.read()

The `encoding` argument should be added to the `open()` calls in *word_count.py* as well on pages 205-206.

<a id="#page_197"></a>
TRY IT YOURSELF
---------------

<a id="#ch10exe1"></a>**10-1. Learning Python:** Open a blank file in your text
editor and write a few lines summarizing what you've learned about
Python so far. Start each line with the phrase *In Python you can\...*.
Save the file as *learning_python.txt* in the same directory as your
exercises from this chapter. Write a program that reads the file and
prints what you wrote three times. Print the contents once by reading in
the entire file, once by looping over the file object, and once by
storing the lines in a list and then working with them outside the
`with` block.

<a id="#ch10exe2}**10-2. Learning C:** You can use the [replace()]{.literal"></a>
method to replace any word in a string with a different word. Here's a
quick example showing how to replace `\'dog\'` with
`\'cat\'` in a sentence:

\>\>\> [message = \"I really like dogs.\"]{.codestrong}
\>\>\> [message.replace(\'dog\', \'cat\')]{.codestrong}
\'I really like cats.\'

Read in each line from the file you just created, *learning_python.txt*,
and replace the word *Python* with the name of another language, such as
*C*. Print each modified line to the screen.
