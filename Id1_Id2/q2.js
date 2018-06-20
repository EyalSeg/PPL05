"use strict";
// q2.ts
Object.defineProperty(exports, "__esModule", { value: true });
;
;
exports.isTreeNode = (x) => x.children !== undefined;
exports.isTreeLeaf = (x) => x.value !== undefined;
exports.isTree = (x) => exports.isTreeNode(x) || exports.isTreeLeaf(x);
// Example values:
exports.t1 = { value: 5 };
exports.t2 = { children: [
        { children: [{ value: 1 }, { value: 7 }, { value: 5 }] },
        { value: 3 },
        { value: 10 }
    ] };
exports.t3 = { children: [
        { children: [{ value: 20 }, { value: 5 }, { value: 50 }] },
        { value: 5 }
    ] };
exports.leftMostEven1 = (atree) => {
    if (exports.isTreeLeaf(atree)) {
        return atree.value % 2 === 0 ?
            atree.value :
            -1;
    }
    let recursive = atree.children.map(exports.leftMostEven1);
    let evens = recursive.filter((x) => x !== -1);
    return evens.length === 0 ?
        -1 :
        evens[0];
};
exports.leftMostEven2 = (atree) => leftMostEven$(atree, (x) => x, () => -1);
const leftMostEven$ = (atree, succ, fail) => {
    if (exports.isTreeLeaf(atree))
        return atree.value % 2 === 0 ?
            succ(atree.value) :
            fail();
    if (atree.children.length === 0)
        return fail();
    let tree_without_left = { children: atree.children.slice(1) };
    return leftMostEven$(atree.children[0], (x) => { return succ(x); }, () => leftMostEven$(tree_without_left, succ, fail));
};
//# sourceMappingURL=q2.js.map