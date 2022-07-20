class RegexValid {
    static username(str: string) {
        const regex = /^[0-9]*[a-zA-Z]([0-9a-zA-Z]|([._\-][0-9a-zA-Z]))*$/; // Username must contains at least at least one alphabetical character and limited special characters which cannot stack on top of each other
        if (!regex.test(str)) {
            return false;
        }
    
        if (str.length > 24) {
            return false;
        }
    
        return true;
    }

    static password(str: string) {
        const regex = /^[0-9a-zA-Z!@#\$%&\*_\-;.\/\{\}\[\]~()]+$/; // Omit ' and " characters from a password
        if (!regex.test(str)) {
            return false;
        }
    
        if (str.length > 32) {
            return false;
        }
    
        return true;
    }

    static location(str: string) {
        const regex = /^[a-zA-Z, ]*$/;
        if (!regex.test(str)) {
            return false;
        }

        if (!regex.test(str)) {
            return false;
        }

        return true;
    }
}

export default RegexValid;
