# "Пчелиные соты" - гексагональный график распределения значений данных по ячейкам сот.

# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1. вчитываем таблицу с данными. делаем из нее исходный датафрейм.
MDepths <- read.csv("Depths.csv", header=TRUE, sep = ",")
Ml <- na.omit(MDepths) 
row.has.na <- apply(Ml, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(Ml)
    # шаг-2. сшиваем столбцы по категориям
MDTt = melt(setDT(Ml), measure = patterns("^profile"), value.name = c("depth"))
head(MDTt)

library(hexbin) 

# ЧАСТЬ-2. рисуем диаграмму-"пчелиные соты".
# 1 вариант ,через library(hexbin)
x = as.factor(MDTt$variable)
y = MDTt$depth
hexbinplot(y ~ x, MDTt, aspect = 1,
           trans = sqrt, inv = function(x) x^2)
x = MDF$profile
y = MDF$Min

hexbinplot(y ~ x, MDF, aspect = 1,
           trans = sqrt, inv = function(x) x^2)

# 2 вариант
bin <- hexbin(x, y)
plot(bin, style = "nested.lattice")

plot(bin, style = "nested.lattice")

# статистика по пчелиному графику
hbi <- hexbin(y ~ x, xbins = 80, IDs= TRUE)
str(hbi)
tI <- table(hbi@cID)
stopifnot(names(tI) == hbi@cell,
tI  == hbi@count)
