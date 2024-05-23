# JVM Languages installation - using Java 11 LTS
# For Java, Clojure and Scala
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (leiningen.override { jdk = pkgs.jdk11; })
    (clojure.override { jdk = pkgs.jdk11; })
    (scala_3.override { jre = pkgs.jdk11; })
    (sbt.override { jre = pkgs.jdk11; })
  ];
}

