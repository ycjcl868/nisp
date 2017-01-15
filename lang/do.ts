// ["do", <exp1>, <exp2>, ...]
export default function (run, ast, sandbox, env) {
    var ret, len = ast.length;
    for (var i = 1; i < len; i++) {
        ret = run(ast[i], sandbox, env);
    }

    return ret;
};