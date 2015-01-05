//ASSIGN: flatten nested arrays into one flat array

 var flatten = function(array){
	var newArray = [];
	for(var i = 0; i<array.length; i++) 
	{
		if (array[i] instanceof Array){
			flatten(array[i]);
			}
		else {
		newArray.push(array[i]);
		}
	}
	return newArray;
}

var array1 = [10, [20, 30], 40];
var array2 = [1, 2, [3], 4, [5, 6]];
flatten(array1);
flatten(array2);

//student solution

//return string of array and refactor into array
//also:

function flatten(array1)
{
	result = [];
	iterate(array1, result)
	return result;

}

function iterate(array, result)
{
	var arrayLength = array.length;
	for (var i = 0; i < arrayLength; i++) 
	{
    
	    if (array[i] instanceof Array)
	    {
	    	iterate(array[i], result)
	    }
	    else result.push(array[i])
	}

}
