class Validators{
  isEmpty({value}){
if(value.isEmpty){
  return 'Should not be empty';
}
return null;
  }
}