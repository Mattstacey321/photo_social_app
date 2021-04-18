enum Reaction { heart, like }

extension ReactionEnum on Reaction {
  static Reaction fromString(int index) => {
        0: Reaction.heart,
        1: Reaction.like,
      }[index];
  String asString() => {
        Reaction.heart: "heart",
        Reaction.like: "like",
      }[this];
}
