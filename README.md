Here's the problem statement; expectation is it should take 1ish days to do it :)

1. Write a simple Mac app that lets user type in text and save as a file.

2. Write a dynamic library that, when included in the previous app, *transparently* encrypts the written out file
  a. "transparent" means for instance that you cannot directly invoke any API in your library from your app (or vice-versa)
  b. You can use a simple XOR based encryption with a one-byte "key" to demonstrate the encryption. i.e., in the encrypted file, each byte is the XOR of the key with the corresponding byte from the original file
3. Write a decryption tool that decrypts the encrypted file and spits out the decrypted file -- this way you can do an end-to-end inspection of the encryption-decryption code path.
4. Can you use your dylib to do transparent encryption in other apps as well? i.e., apps you did not yourself write?
  a. If yes, how would you do it?
  b. If not, why not? What changes/extensions are needed to make this work?
  c. Which apps did you test this with and what were the results?
  d. Feel free to make any required assumptions (e.g., app must be launched in a certain way), but please be sure to list them out. 
5. Please list all external references/code/libs that helped you on the way :)
6. Please submit all the code as a zip/tarball (with build/run instructions if needed)

