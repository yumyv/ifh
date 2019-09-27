class CheckValidInput {
    static check(formSelector, inputTextSelectors, inputNumberSelectors, outputSelector) {
        let inputTextArr = [];
        let inputNumberArr = [];
        if (inputTextSelectors) {
            document.querySelector(formSelector).querySelectorAll(inputTextSelectors).forEach(
                s => inputTextArr.push(s.value));
        }
        if (inputNumberSelectors) {
            document.querySelector(formSelector).querySelectorAll(inputNumberSelectors).forEach(
                s => inputNumberArr.push(s.value));
        }

        const isValidTextInput = (textArr, formSelector, outputSelector) =>{
            if (textArr.every(input => input === '')) {
                textArr = [];
                document.querySelector(formSelector).querySelector(outputSelector).innerHTML = 'Invalid input';
                return false;
            } else {
                if (textArr.every(input => input.length > 0)) {
                    return true;
                } else {
                    document.querySelector(formSelector).querySelector(outputSelector).innerHTML = 'Invalid input';
                    return false;
                }
            }
        };

        const isValidNumberInput = (numberArr, formSelector, outputSelector)=>{
            if (numberArr.every(input => input === '')) {
                numberArr = [];
                document.querySelector(formSelector).querySelector(outputSelector).innerHTML = 'Invalid input';
                return false;
            } else {
                if (numberArr.every(input => !isNaN(input))) {
                    return true;
                } else {
                    document.querySelector(formSelector).querySelector(outputSelector).innerHTML = 'Invalid input';
                    return false;
                }
            }
        };

        if (inputTextSelectors && inputNumberSelectors) {
            return isValidTextInput(inputTextArr,formSelector,outputSelector) &&
                isValidNumberInput(inputNumberArr,formSelector,outputSelector);
        } else if(inputTextSelectors) {
            return isValidTextInput(inputTextArr,formSelector,outputSelector);
        } else if (inputNumberSelectors) {
            return isValidNumberInput(inputNumberArr,formSelector,outputSelector);
        } else return false;
    }
}