/**
 * Tests for the 'utils/string' file.
 */
/** @module tests/utils */
// Do not warn if these variables were not defined before.
/* global QUnit */
QUnit.module("string");

/**
 * Tests for {@link dwv.utils.capitaliseFirstLetter}.
 * @function module:tests/utils~CapitaliseFirstLetter
 */
QUnit.test("Test CapitaliseFirstLetter.", function (assert) {
    // undefined
    assert.equal(dwv.utils.capitaliseFirstLetter(), null, "Capitalise undefined");
    // null
    assert.equal(dwv.utils.capitaliseFirstLetter(null), null, "Capitalise null");
    // empty
    assert.equal(dwv.utils.capitaliseFirstLetter(""), "", "Capitalise empty");
    // short
    assert.equal(dwv.utils.capitaliseFirstLetter("a"), "A", "Capitalise one letter");
    // space first
    assert.equal(dwv.utils.capitaliseFirstLetter(" a"), " a", "Capitalise space");
    // regular
    assert.equal(dwv.utils.capitaliseFirstLetter("dicom"), "Dicom", "Capitalise regular");
    assert.equal(dwv.utils.capitaliseFirstLetter("Dicom"), "Dicom", "Capitalise regular no need");
    // with spaces
    assert.equal(dwv.utils.capitaliseFirstLetter("le ciel est bleu"), "Le ciel est bleu",
            "Capitalise sentence");
});

/**
 * Tests for {@link dwv.utils.replaceFlags}.
 * @function module:tests/utils~ReplaceFlags
 */
QUnit.test("Test ReplaceFlags.", function (assert) {
    // empty/null
    assert.equal(dwv.utils.replaceFlags("", null), "", "ReplaceFlags empty/null");
    // null/null
    assert.equal(dwv.utils.replaceFlags(null, null), "", "ReplaceFlags null/null");
    // empty/undefined
    assert.equal(dwv.utils.replaceFlags(""), "", "ReplaceFlags empty/undefined");
    // real
    var str = "{a}";
    var values = { "a": {"value": 33, "unit": "ohm"} };
    assert.equal(dwv.utils.replaceFlags(str, values), "33.00 ohm", "ReplaceFlags real");
    // real surrounded
    str = "Resistance:{a}.";
    values = { "a": {"value": 33, "unit": "ohm"} };
    assert.equal(dwv.utils.replaceFlags(str, values), "Resistance:33.00 ohm.", "ReplaceFlags surrounded");
    // real no unit
    str = "{a}";
    values = { "a": {"value": 33} };
    assert.equal(dwv.utils.replaceFlags(str, values), "33.00", "ReplaceFlags real no unit");
    // no match
    str = "{a}";
    values = { "b": {"value": 33, "unit": "ohm"} };
    assert.equal(dwv.utils.replaceFlags(str, values), "{a}", "ReplaceFlags no match");
    // no value
    str = "{a}";
    values = { "a": {"unit": "ohm"} };
    assert.equal(dwv.utils.replaceFlags(str, values), "{a}", "ReplaceFlags no value");
    // nothing to do
    str = "a";
    values = { "a": {"value": 33, "unit": "ohm"} };
    assert.equal(dwv.utils.replaceFlags(str, values), "a", "ReplaceFlags nothing to do");
    // nothing to do no values
    str = "a";
    values = {};
    assert.equal(dwv.utils.replaceFlags(str, values), "a", "ReplaceFlags nothing to do no values");
});
