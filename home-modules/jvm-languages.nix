# JVM Languages installation - using Java 11 LTS
# For Java, Clojure and Scala
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk
    (leiningen.override { jdk = pkgs.jdk11; })
    (clojure.override { jdk = pkgs.jdk11; })
    (scala_3.override { jre = pkgs.jdk; })
    (sbt.override { jre = pkgs.jdk; })
  ];
}

