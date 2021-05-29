String getWhereClauseForVersion(String columnName, int/*?*/ version,
    {String tableAlias = ''}) {
  var tableAliasWithDot = tableAlias != '' ? '$tableAlias.' : '';
  return '$tableAliasWithDot"$columnName" ${version == null ? 'IS NULL' : '= $version'}';
}
