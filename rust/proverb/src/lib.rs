pub fn build_proverb(list: Vec<&str>) -> String {
    match list.get(0) {
        None => String::new(),
        Some(val) => {
            let len = list.len() - 1;
            list.iter()
                .enumerate()
                .map(|(i, l)| {
                    if i == len {
                        return format!("And all for the want of a {}.", val);
                    };

                    format!("For want of a {} the {} was lost.", l, list[i + 1])
                })
                .collect::<Vec<String>>()
                .join("\n")
        }
    }
}
