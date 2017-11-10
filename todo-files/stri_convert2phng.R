library(stringi)

files = list.files("R", full.names = TRUE)

file = files[77]

for (file in files) {
  lines = readLines(file)
  pf = parse(file)
  pfd = getParseData(pf)
  head(pfd)
  ind = stri_detect_regex(pfd$text, "makeNumericParamSet")
  ps.loc = as.list(pfd[ind,])
  pfd[pfd$parent == ps.loc$id, ]
  lines[ps.loc$line1:ps.loc$line2]
  mnps = pf[[1]][[3]][[3]][[4]][["par.set"]]

  oneline = stri_paste(lines, collapse = "\n")

  # handle parse makeNumericParamSet
  stri_match_all_regex(oneline, "(?s)(?:ParamHelpers::?)makeNumericParamSet\\(.+\\)")
}