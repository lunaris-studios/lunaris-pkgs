{ nixpkgsDirectory }:
{ packageDirectory }: path: nixpkgsDirectory + "/${packageDirectory}/${path}"