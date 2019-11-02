part of utils;

getImage(String source) {
  if (isURL(source))
    return NetworkImage(source);
  else if (isBase64(source))
    return MemoryImage(base64Decode(source));
  else
    return AssetImage('images/smiley-cyrus.jpg');
}
