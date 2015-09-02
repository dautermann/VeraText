Here's the problem statement; expectation is it should take 1ish days to do it :)

1. Write a simple Mac app that lets user type in text and save as a file.

2. Write a dynamic library that, when included in the previous app, *transparently* encrypts the written out file
  * "transparent" means for instance that you cannot directly invoke any API in your library from your app (or vice-versa)
  * You can use a simple XOR based encryption with a one-byte "key" to demonstrate the encryption. i.e., in the encrypted file, each byte is the XOR of the key with the corresponding byte from the original file
3. Write a decryption tool that decrypts the encrypted file and spits out the decrypted file -- this way you can do an end-to-end inspection of the encryption-decryption code path.
4. Can you use your dylib to do transparent encryption in other apps as well? i.e., apps you did not yourself write?
  * If yes, how would you do it?
  * If not, why not? What changes/extensions are needed to make this work?
  * Which apps did you test this with and what were the results?
  * Feel free to make any required assumptions (e.g., app must be launched in a certain way), but please be sure to list them out. 
5. Please list all external references/code/libs that helped you on the way :)
6. Please submit all the code as a zip/tarball (with build/run instructions if needed)

## And here's how to use it:

1. Open the project in Xcode (I used Xcode 7)

2. Select the "Everything" target from the Build Scheme.  Build it.

3. Run the VeraText app.  You can save a .txt file from it.

4. Wherever you save the file, open it up into TextEdit and observe that it's full of garbage (or encrypted) data.

5. Now run the VeraDecrypt tool from the command line.  

## Let's do something more involved 

1. Recursively clone the "optool" repo via ```git clone --recursive git@github.com:alexzielenski/optool.git``` and build the "`optool`" command line tool.

2. VeraText2.app *does not* link against VeraTextLib.  If you run that and save a file, you'll see the text that's saved is the unencrypted text.

3. Copy the VeraTextLib dylib into the "`MacOS`" folder hiding inside VeraText2's application bundle.

4. To inject the VeraTextLib dylib, go to Terminal and do this command:  ```/PATH/TO/optool install -c load -p "@executable_path/VeraTextLib.framework/VeraTextLib" -t /FULL/PATH/TO/VeraText2.app/Contents/MacOS/VeraText2```

5. Now, when you launch VeraText2.app and save some text, you'll see the saved text is encrypted.

## Now let's get this to work on apps I did not build

1. Make a copy of TextEdit.app. For myself, I copied it into the "`/tmp`" directory.

2. Copy the VeraTextLib dylib into the "`MacOS`" folder hiding inside TextEdit's application bundle.

3. Inject the VeraTextLib dylib via this command: ```/PATH/TO/optool install -c load -p "@executable_path/VeraTextLib.framework/VeraTextLib" -t /private/tmp/TextEdit.app/Contents/MacOS/TextEdit```

4. For your modified TextEdit to run, you need to re-codesign it.  I did it via: ```codesign --force -s "Developer ID Application: Michael Dautermann" /private/tmp/TextEdit.app```

5. Now launch TextEdit and create a new document.  Type in some text.

6. Under the Format menu, choose "Make Plain Text" (or command-T).  This allows us to save .txt files.

7. Save your file.  When you view the contents, they will be encrypted.  They weren't encrypted via my NSString swizzling, but instead via the NSData swizzling.

8. And you can use the VeraDecrypt tool to view the contents.

## Will this work on other apps?

1. Most definitely.  However, I lucked out in that TextEdit was using NSData's writeToURL method to write data to the disk.  Who knows what other apps use, or what methods we'd have to swizzle.

2. To really do this right, I might need to dive deeper (e.g. patching the ultimate "write" function?).  

3. Also, we need to recodesign all apps that we modify, so that's a significant issue going forward.


