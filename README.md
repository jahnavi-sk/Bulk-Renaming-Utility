


# Bulk Renaming Utility


- Allows to easily rename files based on some criteria


### Aim
- To build a bulk renaming utility using UNIX shell scripting language


### Working

- The utility will only rename the image files
	- in particular - only png image formats
- The utility reads all the png files and converts the extension to lowercase png (garden.PNG --> garden.png)
- utility also provides authentication mechanism with username and password
- to make it unique, the renaming is done based on the last 3 digits are used for renaming
	- if number is even - it will be changed to lower-case
	- if number is odd - it will be changed to upper case
