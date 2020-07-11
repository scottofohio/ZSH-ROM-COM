/**
 * JavaScript Sessions & Storage
 *
 * @author Simple Digital
 */

/**
 * Check for local storage browser support
 */
hasStorage = (function() {
    try {
        return !!localStorage.getItem;
    } catch (exception) {
        return false;
    }
}());

/**
 * Local Storage Extensions
 */
Storage.prototype._setItem = Storage.prototype.setItem;
Storage.prototype.setItem = function(key, value) {
    if (hasStorage) {
        this._setItem(key, JSON.stringify(value));
    }
};

Storage.prototype._getItem = Storage.prototype.getItem;
Storage.prototype.getItem = function(key) {
    if (hasStorage) {
        try {
            return JSON.parse(this._getItem(key));
        } catch (e) {
            return this._getItem(key);
        }
    }
};
