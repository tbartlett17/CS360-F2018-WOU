#*****************************************************************
# Name: Tyler Bartlett
# Class:CS360 Fall 2018
# Class time: 1300-1350
# Date: 10/21/18
# Project #: Lab 2
# Driver Name: animate.py
# Program Description: A simple render of a pyramid with a hollow spherical hollow
#                      center and crossed rings sitting inside it. movies are made 
#                      the camera moves around the image and another where a ball
#                      jumps through the rings
# Test Oracle: NA
#				
# NOTES: Stephan Kemper and I worked together.
#
#***************************************************************** 
import os
import re
import math

# Files for IO
inFile = "base.pov"
outFile = "tmp.pov"
part1_movie = "movie-Part_1.avi"
part2_movie = "movie-Part_2.avi"

# Open a file and read its contents to a string
def openBaseFile():
    fin = open( inFile, "r" ) # open file with read access
    sdl = fin.read() # Read the entire file into a string
    fin.close() #close file
    return sdl #return sdl string containing file contents

# Create a new temp pov file based off the passed in SDL
def newTempFile(sdl_new):
    fout = open(outFile, "w" ) # open file with write access
    fout.write(sdl_new) # write string to file
    fout.close()  # close the file

# Runs the pov file to generate a render
def povCmd(imgFile):
    pov_cmd = "pvengine.exe +I%s +O%s -D -V +A0.5 +H720 +W1080 /EXIT"
    cmd = pov_cmd % (outFile, imgFile)
    print(cmd)
    os.system(cmd)

# Moves the camera position in the POV SDL to the given (x,y,z)
def modCamLoc(sdl, x, y, z):
    oldCamLoc = r'location <*\d*.*\d, *\d*.*\d, *\d*.*\d>' #the old camera location where *\d.*\d is any float
    newCamLoc = r'location <%f, %f, %f>' % (x, y, z) # the new Camera Location
    sdl = re.sub(oldCamLoc, newCamLoc, sdl) # update the old camera location to the new location
    return sdl

# encodes the movie from all the images
def encodeMovie (movieName):
    ffmpeg_cmd = "ffmpeg -start_number 1 -i temp%01d.png -c:v libx264 -r 30 -pix_fmt yuv420p " 
    cmd = ffmpeg_cmd + movieName
    print ("Encoding Movie...")
    os.system(cmd)

# delete all temp fies
def cleanUp ():
    print ("Deleting temp images...")
    os.system('del temp*.png')
    print ("Deleting tmp.pov")
    os.system('del tmp.pov')
    print ("Done")

# Runs part one of the lab
def renderPartI():
    sdl = openBaseFile() # read from the base file
    camXpos = 0 # initial camera position
    camYpos = 0.8 # initial camera position
    camZpos = 0 # initial camera position
    theta = 0 # angle of camera from origin in degrees
    thetaMod = 0.1 # amount to add to theta
    r = 6 # radius of camera path
    panUP = True # decide to move up or down 
    for i in range (0, 900): #number of frames
        camXpos = r*math.cos(theta) # new pos for camera, moving in a circle (xz-plane)
        camZpos = r*math.sin(theta) # new pos for camera, moving in a circle (xz-plane)
        theta += thetaMod # moves the camera angle slightly
        #move the camera up and down in y plane
        if (panUP == True):
            camYpos += 0.1
        if (panUP == False):
            camYpos -= 0.1
        if (camYpos <= 0.5):
            panUP = True
        if (camYpos >= 3.8):
            panUP = False    
        imgFile = "temp" + str(i)+ ".png" # image name changes with each iteration
        sdl = modCamLoc(sdl, camXpos, camYpos, camZpos) # update camera location
        newTempFile(sdl) # write the new temp file to render
        povCmd(imgFile) # render the new image

# creates and adds a sphere to the sdl
def createMarble(sdl, x, y, z):
    r = 0.25 # radius of marble
    R = 1 # color value
    G = 0.6  # color value
    B = 0.9 # color value
    marble = " \nsphere {\n\t<%f,%f,%f>, %f\n\ttexture {\n\t\tpigment {color rgb <%f, %f, %f>}\n\t}\n}" % (x,y,z,r,R,G,B)
    sdl += marble
    return sdl

# update the position of the sphere
def moveMarble (sdl, x, y, z):
    oldMarLoc = r'sphere {\n\t<*\d*.*\d, *\d*.*\d, *\d*.*\d>' #the old marble location where *\d.*\d is any float
    newMarLoc = r'sphere {\n\t<%f, %f, %f>' % (x, y, z) # the new Camera Location
    sdl = re.sub(oldMarLoc, newMarLoc, sdl) # update the old camera location to the new location
    return sdl

#runs part 2 of lab
def renderPartII():
    sdl = openBaseFile() # read from the base file
    marXpos = 4 # marble x position
    marYpos = 0 # marble y position
    marZpos = -0.2 # marble z position
    sdl = createMarble(sdl, marXpos, marYpos, marZpos) # add marble to sdl
    jump = True # logic for conditions for ball to jump through rings
    for i in range (0, 900): # of frames
        marXpos -= 0.07
        #conditional logic to make the orb move in a manner i somewhat want
        if (jump == True and marXpos <= 2.3 and marXpos >=-1.5):
            marYpos += .08
        if (jump == False and marXpos <= 2.3 and marXpos >=-1.5):
            marYpos -= .04
            marZpos +=0.01 
        if (marYpos >= 1.5):
            jump = False
        if (marYpos <=0):
            jump = True
        if (marXpos <=-2.3):
            marXpos = -2.3
            marZpos += 0.25
            if (marZpos >= 9):
                marXpos = 4
                marYpos = 0
                marZpos = -0.2
        sdl = moveMarble(sdl=sdl, z=marZpos, x=marXpos, y=marYpos) #move the marble
        imgFile = "temp" + str(i)+ ".png" # image name changes with each iteration
        newTempFile(sdl) # write the new temp file to render
        povCmd(imgFile) # render the new image


######################################## 
#             Begin Main               #
########################################
renderPartI() # renders images following guidlines for part 1 of lab
encodeMovie(part1_movie) # renders movies from images
cleanUp() # destroy temp files

renderPartII() # renders images following guidlines for part 2 of lab
encodeMovie(part2_movie) # renders movies from images
cleanUp() # destroy temp files
