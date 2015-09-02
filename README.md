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

And here's how to use it:

1. Open the project in Xcode (I used Xcode 7)

2. Select the "Everything" target from the Build Scheme.  Build it.

3. Run the VeraText app.  You can save a .txt file from it.

4. Wherever you save the file, open it up into TextEdit and observe that it's full of garbage (or encrypted) data.

5. Now run the VeraDecrypt tool from the command line.  

