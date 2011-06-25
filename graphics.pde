
float singraph(float sa) {
  sa = (sa - 0.5) * 1.0; //scale from -1 to 1
  sa = sin(sa*PI)/2 + 0.5;
  return sa;
}

float quadHump(float sa) {
  sa = (sa - 0.5); //scale from -2 to 2
  sa = sa*sa*sa*sa * 16;
  return sa;
}

float hump(float sa) {
  sa = (sa - 0.5) * 2; //scale from -2 to 2
  sa = sa*sa;
  if(sa > 1) { sa = 1; }
  return 1-sa;
}

float squared(float sa) {
  sa = sa*sa;
  return sa;
}
