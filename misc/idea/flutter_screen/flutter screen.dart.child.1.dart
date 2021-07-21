#set($camelcase_name = ${StringUtils.removeAndHump(${NAME})})

class ${camelcase_name}State {
  const ${camelcase_name}State();
}

${camelcase_name}State use${camelcase_name}State() {
  return ${camelcase_name}State();
}
