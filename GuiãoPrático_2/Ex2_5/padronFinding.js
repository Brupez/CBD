function findingDifferent() {

    db.phones.find().forEach(function (doc) {
        const number = doc.components.number;

        if (isDifferent(number)) {
            console.log(number);
        }
    });
}

function isDifferent(number) {

    //hashmap iterar a string

    //ITERATION MODE
    //More Readable

    //const textnumber = number.toString();

    //for (let i = 0; i < textnumber.length - 1; i++) {
    //    if (textnumber.indexOf(textnumber[i], i + 1) > -1) {
    //        return false
    //    }
    //}

    //return true;

    //REGEX MODE
    //More Efficient
    const hasRepeatNum = /(\d).*\1/.test(number);

    return !hasRepeatNum;

    //Option 3 (simplier)
    //Save in a hashmap and iterate the string checking if there is equal

    //run mongo on the server-side
    /*db.phones.find({
       $expr: {
         $function: {
             body: isDifferent,
             args: "$display",
             lang: js
         }
       }
    });*/
}