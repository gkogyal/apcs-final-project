class Util{
  int locateArr(Object target, Object[] arr) {
     for(int i = 0; i<arr.length; i++) {
       if(target.equals(arr[i])) return i;
     }
     return -1;
  }
}
