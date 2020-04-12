const bcryptjs = require('bcryptjs');
const helpers = {};

helpers.encryppassword = async(password) => {
    const salt = await bcryptjs.genSalt(10);
    const hash = await bcryptjs.hash(password, salt);
    return hash;
};

helpers.matchpassword = async(password, savedpassword) => {
    try {
        return await bcryptjs.compare(password, savedpassword);
    } catch (e) {
        console.log(e);
    }
};

module.exports = helpers;