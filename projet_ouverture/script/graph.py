#!/usr/bin/env python3
import pandas as pd
import matplotlib.pyplot as plt
import os

df = pd.read_csv("../results.csv")

os.makedirs("../graphes", exist_ok=True)

algos = df["algo"].unique()
rows = []
for algo in algos:
    rows.append({
        "algo": algo,
        "n": 0,
        "trial": 0,
        "time_ms": 0,
        "height": 0,
        "width": 0,
        "size": 0,
        "left_size": 0,
        "avg_leaf_depth": 0
    })

df0 = pd.DataFrame(rows)
df = pd.concat([df0, df], ignore_index=True)

df = df.sort_values(["algo", "n"])

def plot_y(y, ylabel):
    plt.figure()
    for algo in df["algo"].unique():
        sub = df[df["algo"] == algo]
        means = sub.groupby("n")[y].mean()
        plt.plot(means.index, means.values, label=algo)

    plt.xlabel("Tree size")
    plt.ylabel(ylabel)
    plt.xlim(left=0)
    plt.legend()
    ax = plt.gca()
    ax.spines["left"].set_position("zero")
    ax.spines["bottom"].set_position("zero")

    ax.spines["right"].set_color("none")
    ax.spines["top"].set_color("none")

    ax.xaxis.set_ticks_position("bottom")
    ax.yaxis.set_ticks_position("left")
    ticks = ax.get_xticks()
    ticks = [t for t in ticks if t != 0]
    ax.set_xticks(ticks)
    plt.tight_layout()
    plt.savefig(f"../graphes/{y}.png")
    plt.close()

plot_y("height", "Height")
plot_y("width", "Width")
plot_y("time_ms", "Execution time (ms)")
plot_y("avg_leaf_depth", "Average leaf depth")