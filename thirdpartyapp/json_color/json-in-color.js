String.prototype.jsonColor = function() {
	var jsonLine = /^( *)("[\w.+-]+": )?("[^"]*"|[\w.+-]*)?([,[{])?$/mg,
		replacer = function(match, pIndent, pKey, pVal, pEnd) {
		var key = '<span style="color: #b16b2a;">',
			val = '<span style="color: #2f6cd2;font-weight:bold;">',
			str = '<span style="color: #008000;">';
		var r = pIndent || '';
		if (pKey) {
			r = r + key + pKey.replace(/[": ]/g, '') + '</span>: ';
		}
		if (pVal) {
			r = r + (pVal[0] == '"' ? str : val) + pVal + '</span>';
		}
		return r + (pEnd || '');
	};
	return this
		.replace(/&/g, '&amp;').replace(/\\"/g, '&quot;')
		.replace(/</g, '&lt;').replace(/>/g, '&gt;')
		.replace(jsonLine, replacer);
};


function JSONstringify(json) {
    if (typeof json != 'string') {
        json = JSON.stringify(json, undefined, '\t');
    }

    var 
        arr = [],
        _string = 'color:green',
        _number = 'color:darkorange',
        _boolean = 'color:blue',
        _null = 'color:magenta',
        _key = 'color:red';

    json = json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var style = _number;
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                style = _key;
            } else {
                style = _string;
            }
        } else if (/true|false/.test(match)) {
            style = _boolean;
        } else if (/null/.test(match)) {
            style = _null;
        }
        arr.push(style);
        arr.push('');
        return '%c' + match + '%c';
    });

    arr.unshift(json);

    console.log.apply(console, arr);
}